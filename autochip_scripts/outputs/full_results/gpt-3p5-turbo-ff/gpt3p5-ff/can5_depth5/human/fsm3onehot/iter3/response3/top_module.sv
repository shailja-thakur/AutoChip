module top_module (
    input wire in,
    input wire [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

    always @(state or in)
    begin
        case(state)
            4'b0001: begin // State A
                if(in) begin
                    next_state <= 4'b0010; // Next state: B
                end
                else begin
                    next_state <= 4'b0001; // Next state: A
                end
                out <= 1'b0; // Output: 0
            end
            
            4'b0010: begin // State B
                if(in) begin
                    next_state <= 4'b0010; // Next state: B
                end
                else begin
                    next_state <= 4'b0100; // Next state: C
                end
                out <= 1'b0; // Output: 0
            end
            
            4'b0100: begin // State C
                if(in) begin
                    next_state <= 4'b0001; // Next state: A
                end
                else begin
                    next_state <= 4'b1000; // Next state: D
                end
                out <= 1'b0; // Output: 0
            end
            
            4'b1000: begin // State D
                if(in) begin
                    next_state <= 4'b0100; // Next state: C
                end
                else begin
                    next_state <= 4'b0010; // Next state: B
                end
                out <= 1'b1; // Output: 1
            end
            
            default: begin
                next_state <= 4'bxxxx; // Invalid state, next state is don't care
                out <= 1'bx; // Output is undefined
            end
        endcase
    end

endmodule
