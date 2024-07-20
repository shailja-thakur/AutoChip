module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b0;
        else begin
            case (state)
                3'b000: begin
                    if (w)
                        state <= 3'b001;
                    else
                        state <= 3'b000;
                end
                3'b001: begin
                    if (w)
                        state <= 3'b010;
                    else
                        state <= 3'b100;
                end
                3'b010: begin
                    if (w)
                        state <= 3'b110;
                    else
                        state <= 3'b011;
                end
                3'b011: begin
                    if (w)
                        state <= 3'b100;
                    else
                        state <= 3'b100;
                end
                3'b100: begin
                    if (w)
                        state <= 3'b100;
                    else
                        state <= 3'b011;
                end
                default: begin
                    if (w)
                        state <= 3'b010;
                    else
                        state <= 3'b110;
                end
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3'b110 || state == 3'b111)
            z <= 1;
        else
            z <= 0;
    end

endmodule
