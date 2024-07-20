module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] state;

    // The reset input initializes the state to A
    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 3'b001; // A
        else begin
            case(state)
                // If the state is A and x is low, then the next state is also A
                3'b001: begin
                    if (x == 1'b0)
                        state <= 3'b001; // A
                    else
                        state <= 3'b010; // B
                end
                // If the state is B and x is low, then the next state is B
                3'b010: begin
                    if (x == 1'b0)
                        state <= 3'b010; // B
                    else
                        state <= 3'b101; // E
                end
                // If the state is C and x is low, then the next state is C
                3'b011: begin
                    if (x == 1'b0)
                        state <= 3'b011; // C
                    else
                        state <= 3'b010; // B
                end
                // If the state is D and x is low, then the next state is B
                3'b100: begin
                    if (x == 1'b0)
                        state <= 3'b010; // B
                    else
                        state <= 3'b011; // C
                end
                // If the state is E and x is low, then the next state is D
                3'b101: begin
                    if (x == 1'b0)
                        state <= 3'b100; // D
                    else
                        state <= 3'b101; // E
                end
                default: state <= 3'b001; // A
            endcase
        end
    end

    // The output is high when the state is D or E
    always @(state) begin
        if (state == 3'b100 || state == 3'b101)
            z <= 1'b1;
        else
            z <= 1'b0;
    end
endmodule
