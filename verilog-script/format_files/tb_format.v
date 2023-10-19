`define modelsim
`timescale 1ns/1ns

module testbench;
    localparam CLK_PERIOD = 10;
    localparam CYCLE_HALF = CLK_PERIOD/2;
    localparam TIMEOUT = 1_000_000;

    reg clk;
    reg n_rst;


    (
        .clk (clk),
        .n_rst (n_rst),
    );

    initial begin
        clk = 1'b0;
        n_rst = 1'b0;
        #7; n_rst = 1'b1;
    end

    task stop;
    begin
        `ifdef modelsim
            $stop;
        `endif

        `ifndef modelsim
            $finish;
        `endif
    end
    endtask

    always #(CYCLE_HALF) clk = ~clk;

    initial begin
        wait(n_rst);
        @(posedge clk);
        stop;
    end

    `ifndef modelsim
        initial begin
            $fsdbDumpfile("test.fsdb");
            $fsdbDumpvars(0);
        end
    `endif

    initial begin
        repeat(TIMEOUT) @(posedge clk);
        $display("TIMEOUT!");
        stop;
    end
endmodule