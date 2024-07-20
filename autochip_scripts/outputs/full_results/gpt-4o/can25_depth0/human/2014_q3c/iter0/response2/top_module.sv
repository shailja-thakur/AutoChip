module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] state;

    // State transition based on x and current state (y)
    always @(posedge clk) begin
        case (y)
            3'b000: state = (x == 0) ? 3'b000 : 3'b001;
            3'b001: state = (x == 0) ? 3'b001 : 3'b100;
            3'b010: state = (x == 0) ? 3'b010 : 3'b001;
            3'b011: state = (x == 0) ? 3'b001 : 3'b010;
            3'b100: state = (x == 0) ? 3'b011 : 3'b100;
            default: state = 3'b000; // default case for safety
        endcase
    end

    // Assign the output Y0 and z based on the next state
    always @(posedge clk) begin
        Y0 <= state[0]; // Output Y0 is the least significant bit of the next state

        case (state)
            3'b011,
            3'b100: z = 1;
            default: z = 0; 
        endcase
    end

endmodule
