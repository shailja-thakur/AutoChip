module top_module (
    input clk,
    input in,
    input areset,
    output out
);
	
    reg [1:0] state;
    reg out_reg;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // reset to B
            out_reg <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // A
                    if (in == 1'b0)
                        state <= 2'b10; // B
                    else
                        state <= 2'b00; // A
                end
                2'b01: begin // B
                    if (in == 1'b0)
                        state <= 2'b01; // B
                    else
                        state <= 2'b00; // A
                end
                default: state <= 2'b10; // B
            endcase
            out_reg <= (state == 2'b00) ? 1'b1 : 1'b0;
        end
    end
	
    always @(posedge clk) begin
        out <= out_reg;
    end
	
endmodule
