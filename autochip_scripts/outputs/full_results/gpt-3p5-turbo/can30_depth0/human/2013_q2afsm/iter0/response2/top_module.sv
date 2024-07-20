module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    
    reg [3:1] state;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= 3'b001;
        end else begin
            case(state)
                3'b001: begin
                    if (r[1]) begin
                        state <= 3'b010;
                    end else if (r[2]) begin
                        state <= 3'b011;
                    end else if (r[3]) begin
                        state <= 3'b100;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b010: begin
                    if (r[1]) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b011: begin
                    if (r[2]) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b001;
                    end
                end
                3'b100: begin
                    if (r[3]) begin
                        state <= 3'b100;
                    end else begin
                        state <= 3'b001;
                    end
                end
                default: state <= 3'b001;
            endcase
        end
    end
    
    assign g[1] = (state == 3'b010 || state == 3'b100) ? 1'b1 : 1'b0;
    assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0;
    assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0;

endmodule
