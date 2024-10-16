`timescale 1ns / 1ps

module energy_efficient_cnn_tb;

    reg clk;
    reg rst;
    reg [63:0] image_input;
    reg start;
    wire [3:0] classification;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    energy_efficient_cnn uut (
        .clk(clk),
        .rst(rst),
        .image_input(image_input),
        .start(start),
        .classification(classification),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        image_input = 0;
        start = 0;

        // Reset
        #100;
        rst = 0;

        // Test case 1: Simple image (all zeros except one pixel)
        #10;
        image_input = 64'h0000000000000080;  // Single pixel set in the last row
        start = 1;
        #10;
        start = 0;

        // Wait for processing to complete
        wait(done);
        $display("Test case 1 - Classification: %d", classification);

        // Test case 2: Different image pattern
        #100;
        image_input = 64'h00FF00FF00FF00FF;  // Alternating rows of all on/off pixels
        start = 1;
        #10;
        start = 0;

        // Wait for processing to complete
        wait(done);
        $display("Test case 2 - Classification: %d", classification);

        // Add more test cases as needed

        // End simulation
        #100;
        $finish;
    end

    // Optional: Uncomment to generate VCD file for waveform viewing
    initial begin
         $dumpfile("waveform.vcd");
         $dumpvars(0, energy_efficient_cnn_tb);
    end

endmodule