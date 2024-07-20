module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // Initialize the state to A
    else begin
        case (state)
            3'b000: begin // State A
                if (x)
                    state <= 3'b001; // Next state is B
                else
                    state <= 3'b000; // Next state is A
            end
            
            3'b001: begin // State B
                if (x)
                    state <= 3'b100; // Next state is E
                else
                    state <= 3'b001; // Next state is B
            end
            
            3'b010: begin // State C
                if (x)
                    state <= 3'b001; // Next state is B
                else
                    state <= 3'b010; // Next state is C
            end
            
            3'b011: begin // State D
                if (x)
                    state <= 3'b010; // Next state is C
                else
                    state <= 3'b001; // Next state is B
            end
            
            3'b100: begin // State E
                if (x)
                    state <= 3'b100; // Next state is E
                else
                    state <= 3'b011; // Next state is D
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == 3'b100 || state == 3'b101) // State D or E
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
