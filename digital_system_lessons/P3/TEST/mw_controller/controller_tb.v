`timescale 1ms/1ms
`include "./LVL1/MWcontroller.v"

module tb_;
    reg clk_tb, startn, stopn, clearn, door_closed;
    reg [9:0] keypad;
    wire [6:0] sec_ones_segs, sec_tens_segs, min_ones_segs, min_tens_segs;
    wire mag_on;

    MWcontroller dut(
    .clk(clk_tb), .keypad(keypad),
    .startn(startn), .stopn(stopn), .clearn(clearn), .door_closed(door_closed),
    .mag_on(mag_on),
    .sec_ones_segs(sec_ones_segs), .sec_tens_segs(sec_tens_segs), .min_ones_segs(min_ones_segs), .min_tens_segs(min_tens_segs)
);
    localparam clk_period = 10;
    always #(clk_period/2) clk_tb=~clk_tb;

    initial
        begin
            $dumpfile("tb.vcd");
            $dumpvars(0, tb_);

            // case 1
            clk_tb = 1'b1;
            startn = 1'b1;
            door_closed = 1'b1;
            stopn = 1'b1;
            keypad = 10'b0000000000;
            clearn = 1'b0;
            #1;
            clearn = 1'b1;
            #1;
            keypad = 10'b0000000010;
            #100;
            keypad = 10'b0000000100;
            #100;
            startn = 1'b0;
            #8000;
            door_closed = 1'b0;
            #2000
            door_closed = 1'b1;
            #3000;
            stopn = 1'b0;
            #1000
            stopn = 1'b1;
            #1

            // case 2
            clk_tb = 1'b1;
            startn = 1'b1;
            door_closed = 1'b1;
            stopn = 1'b1;
            keypad = 10'b0000000000;
            clearn = 1'b0;
            #1 clearn = 1'b1;
            #1 keypad = 10'b0010000000;
            #100
            keypad = 10'b0000000001;
            #100
            startn = 1'b0;
            #8000

        $finish();        
        end

endmodule