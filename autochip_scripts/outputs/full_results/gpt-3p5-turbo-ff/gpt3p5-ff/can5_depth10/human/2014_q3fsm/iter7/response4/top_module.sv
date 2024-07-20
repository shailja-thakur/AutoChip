module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state;
    reg [2:0] w_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            w_count <= 3'b000;
            z <= 0;
        end else begin
            case (state)
                2'b00: begin
                    if (s == 1)
                        state <= 2'b01;
                end
                2'b01: begin
                    state <= 2'b10;
                    w_count <= 3'b000;
                end
                2'b10: begin
                    if (w == 1)
                        w_count <= w_count + 1;
                    if (w_count == 3'b110) begin
                        state <= 2'b00;
                        z <= 1;
                    end else begin
                        state <= 2'b10;
                        z <= 0;
                    end
                end
                default: begin
                    state <= 2'b00;
                end
            endcase
        end
    end
    
endmodule
