module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00; // Set state to A when resetn is low
    else
        state <= next_state; // Set state to the next state

    // Next state logic
    case (state)
        2'b00: begin // If current state is A
            if (r[2])
                next_state = 2'b10; // Next state is C if r[2] is high
            else if (r[1])
                next_state = 2'b01; // Next state is B if r[1] is high
            else if (r[0])
                next_state = 2'b11; // Next state is D if r[0] is high
            else
                next_state = 2'b00; // Next state is A if no bits of r are high
        end
        2'b01: begin // If current state is B
            if (r[1])
                next_state = 2'b01; // Next state is B if r[1] is high
            else
                next_state = 2'b00; // Next state is A if r[1] is low
        end
        2'b10: begin // If current state is C
            if (r[2])
                next_state = 2'b10; // Next state is C if r[2] is high
            else
                next_state = 2'b00; // Next state is A if r[2] is low
        end
        2'b11: begin // If current state is D
            if (r[0])
                next_state = 2'b11; // Next state is D if r[0] is high
            else
                next_state = 2'b00; // Next state is A if r[0] is low
        end
    endcase
end

// Assign output vector g based on current state
always @* begin
    case (state)
        2'b01: g[2] = 1'b1; // If current state is B, g[2] is high
        2'b10: g[1] = 1'b1; // If current state is C, g[1] is high
        2'b11: g[0] = 1'b1; // If current state is D, g[0] is high
        default: g[2:0] = 3'b000; // Default state, all bits of g are low
    endcase
end

endmodule
