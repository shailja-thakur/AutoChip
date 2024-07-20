module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (!resetn) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (r[0]) begin
                        state <= 2'b01;
                    end else if (r[1]) begin
                        state <= 2'b10;
                    end else if (r[2]) begin
                        state <= 2'b11;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (r[0]) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b10: begin
                    if (r[1]) begin
                        state <= 2'b10;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b11: begin
                    if (r[2]) begin
                        state <= 2'b11;
                    end else begin
                        state <= 2'b00;
                    end
                end
                default: begin
                    state <= 2'b00;
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b01: g <= 3'b001;
            2'b10: g <= 3'b010;
            2'b11: g <= 3'b100;
            default: g <= 3'b000;
        endcase
    end
endmodule
