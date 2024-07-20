module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001;
        end else begin
            case (state)
                3'b001: // state A
                    if (x) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b001;
                    end
                3'b010: // state B
                    if (x) begin
                        state <= 3'b100;
                    end else begin
                        state <= 3'b010;
                    end
                3'b011: // state C
                    if (x) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b011;
                    end
                3'b100: // state D
                    if (x) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b010;
                    end
                3'b101: // state E
                    if (x) begin
                        state <= 3'b101;
                    end else begin
                        state <= 3'b100;
                    end
                default:
                    state <= 3'b001;
            endcase
        end
    end
    
    always @(*) begin
        if (state == 3'b100 || state == 3'b101) begin
            z = 1;
        end else begin
            z = 0;
        end
    end
    
endmodule
