module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [23:0] out_reg;
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            out_reg <= 0;
            done <= 0;
        end else begin
            case (state)
                3'b000: begin
                    if (in[2] == 0) begin
                        state <= 3'b000;
                        out_reg <= {out_reg[15:0], in};
                    end else begin
                        state <= 3'b001;
                        out_reg <= {out_reg[15:0], in};
                    end
                end
                3'b001: begin
                    state <= 3'b010;
                    out_reg <= {out_reg[15:0], in};
                end
                3'b010: begin
                    state <= 3'b011;
                    out_reg <= {out_reg[15:0], in};
                end
                3'b011: begin
                    state <= 3'b100;
                    out_reg <= {out_reg[15:0], in};
                end
                3'b100: begin
                    if (in[2] == 0) begin
                        state <= 3'b000;
                        out_reg <= {out_reg[15:0], in};
                    end else begin
                        state <= 3'b001;
                        out_reg <= {out_reg[15:0], in};
                    end
                end
                default: begin
                    state <= 3'b000;
                    out_reg <= 0;
                    done <= 0;
                end
            endcase
            done <= (state == 3'b100) ? 1 : 0;
        end
    end
    
    assign out_bytes = (done) ? out_reg : 0;

endmodule
