module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    reg[2:0] state;
    
    always @(posedge clk or negedge reset) begin
        if (reset == 1'b0) begin
            state <= 3'b000;
        end else begin
            case(state)
                3'b000: if (w == 1'b0) state <= 3'b000; else state <= 3'b001;
                3'b001: if (w == 1'b0) state <= 3'b010; else state <= 3'b011;
                3'b010: if (w == 1'b0) state <= 3'b110; else state <= 3'b000;
                3'b011: if (w == 1'b0) state <= 3'b000; else state <= 3'b100;
                3'b100: if (w == 1'b0) state <= 3'b010; else state <= 3'b100;
                3'b110: if (w == 1'b0) state <= 3'b010; else state <= 3'b011;
            endcase
        end
    end
    
    always @(state) begin
        if (state == 3'b110 || state == 3'b100) begin
            z <= 1'b1;
        end else begin
            z <= 1'b0;
        end
    end
    
endmodule
