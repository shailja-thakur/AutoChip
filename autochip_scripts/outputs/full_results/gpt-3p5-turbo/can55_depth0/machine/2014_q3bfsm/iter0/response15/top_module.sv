module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state; // Internal state represented by 3 bits

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b00; // Initialize state to A when reset is high
    else begin
        case (state)
            3'b00: begin // State A
                if (x == 1'b0)
                    state <= 3'b00; // Next state is A if x is low
                else
                    state <= 3'b01; // Next state is B if x is high
            end
            3'b01: begin // State B
                if (x == 1'b0)
                    state <= 3'b01; // Next state is B if x is low
                else
                    state <= 3'b10; // Next state is E if x is high
            end
            3'b10: begin // State C
                if (x == 1'b0)
                    state <= 3'b10; // Next state is C if x is low
                else
                    state <= 3'b01; // Next state is B if x is high
            end
            3'b11: begin // State D
                if (x == 1'b0)
                    state <= 3'b01; // Next state is B if x is low
                else
                    state <= 3'b10; // Next state is C if x is high
            end
            3'b100: begin // State E
                if (x == 1'b0)
                    state <= 3'b11; // Next state is D if x is low
                else
                    state <= 3'b100; // Next state is E if x is high
            end
            default: state <= 3'b00; // Default state is A if none of the above conditions are met
        endcase
    end
end

// Output z is high when the state is D or E
always @(state) begin
    if (state == 3'b11 || state == 3'b100)
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
