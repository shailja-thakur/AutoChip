module top_module (
    input wire clk,
    input wire in,
    input wire areset,
    output wire out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00; // reset to state A
        end else begin
            case (state)
                2'b00: begin // state A
                    if (in) begin
                        state <= 2'b01; // next state B
                    end else begin
                        state <= 2'b00; // next state A
                    end
                end
                
                2'b01: begin // state B
                    if (in) begin
                        state <= 2'b01; // next state B
                    end else begin
                        state <= 2'b10; // next state C
                    end
                end
                
                2'b10: begin // state C
                    if (in) begin
                        state <= 2'b11; // next state D
                    end else begin
                        state <= 2'b00; // next state A
                    end
                end
                
                2'b11: begin // state D
                    if (in) begin
                        state <= 2'b01; // next state B
                    end else begin
                        state <= 2'b10; // next state C
                    end
                end
            endcase
        end
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;
    
endmodule
