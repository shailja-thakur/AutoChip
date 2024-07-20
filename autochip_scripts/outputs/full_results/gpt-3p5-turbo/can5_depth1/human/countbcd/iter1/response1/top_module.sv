module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

    // Define internal signals
    reg [15:0] next_q;
    reg [2:0] counter;

    // Synchronous logic for counter
    always @(posedge clk or posedge reset) begin
        if (reset)
            next_q <= 0;
        else begin
            counter <= counter + 1;
            if (counter == 3'b100)
                counter <= 0;
            if (counter == 3'b001 || reset)
                next_q[3:0] <= next_q[3:0] + 1;
            if (counter == 3'b010)
                next_q[7:4] <= next_q[7:4] + 1;
            if (counter == 3'b100)
                next_q[11:8] <= next_q[11:8] + 1;
            if (counter == 3'b001 || reset)
                next_q[15:12] <= next_q[15:12] + 1;
        end
    end

    // Assign outputs
    assign q = next_q;
    assign ena = {1'b0, counter};

endmodule
