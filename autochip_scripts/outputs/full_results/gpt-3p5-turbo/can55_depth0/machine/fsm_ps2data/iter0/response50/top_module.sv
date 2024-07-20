module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    reg [2:0] state;
    reg [23:0] out_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            out_reg <= 24'b0;
        end else begin
            case (state)
                3'b000: begin
                    if (in[2] == 1'b1) begin
                        state <= 3'b001;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin
                    state <= 3'b010;
                end
                3'b010: begin
                    state <= 3'b011;
                end
                3'b011: begin
                    state <= 3'b100;
                end
                3'b100: begin
                    state <= 3'b000;
                end
                default: begin
                    state <= 3'b000;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else if (state == 3'b100) begin
            out_bytes <= out_reg;
        end else begin
            out_reg <= {out_reg[15:0], in};
        end
    end
    
    assign done = (state == 3'b100);
endmodule
