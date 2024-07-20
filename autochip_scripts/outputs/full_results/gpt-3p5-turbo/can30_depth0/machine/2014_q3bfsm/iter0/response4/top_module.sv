module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b100; // Initialize state to A
        end else begin
            case (state)
                3'b100: begin // State A
                    if (x) begin
                        state <= 3'b010; // Next state is B
                    end else begin
                        state <= 3'b100; // Next state is A
                    end
                end
                3'b010: begin // State B
                    if (x) begin
                        state <= 3'b111; // Next state is E
                    end else begin
                        state <= 3'b010; // Next state is B
                    end
                end
                3'b001: begin // State C
                    if (x) begin
                        state <= 3'b010; // Next state is B
                    end else begin
                        state <= 3'b001; // Next state is C
                    end
                end
                3'b110: begin // State D
                    if (x) begin
                        state <= 3'b001; // Next state is C
                    end else begin
                        state <= 3'b010; // Next state is B
                    end
                end
                3'b011: begin // State E
                    if (x) begin
                        state <= 3'b011; // Next state is E
                    end else begin
                        state <= 3'b110; // Next state is D
                    end
                end
                default: state <= state; // Unspecified state, no transition
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3'b011 || state == 3'b111) begin
            z <= 1'b1; // Set output high when state is D or E
        end else begin
            z <= 1'b0;
        end
    end

endmodule
