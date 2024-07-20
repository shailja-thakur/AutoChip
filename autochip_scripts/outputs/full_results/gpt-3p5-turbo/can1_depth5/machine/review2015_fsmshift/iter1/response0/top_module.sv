module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state);
    
    reg [2:0] prev_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // B0
        end else begin
            prev_state <= state;
            
            case (prev_state)
                3'b000: begin
                    state <= 3'b001; // B1
                end
                3'b001: begin
                    state <= 3'b010; // B2
                end
                3'b010: begin
                    state <= 3'b011; // B3
                end
                3'b011: begin
                    state <= 3'b100; // Done
                end
                default: begin
                    state <= 3'b100; // Done
                end
            endcase
        end
    end
    
    assign shift_ena = (prev_state == 3'b000) ? 1'b1 : 1'b0;
    
endmodule
