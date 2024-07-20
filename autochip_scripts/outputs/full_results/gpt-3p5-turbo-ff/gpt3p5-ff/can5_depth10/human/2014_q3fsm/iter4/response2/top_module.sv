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
            state <= 2'b0;
            w_count <= 3'b0;
            z <= 1'b0;
        end else begin
            case (state)
                2'b00: begin
                    if (s == 1)
                        state <= 2'b01;
                end
                2'b01: begin
                    w_count <= w_count + 1;
                    if (w_count == 3'b111 || (w_count == 3'b110 && w == 1)) begin
                        z <= 1'b1;
                        w_count <= 3'b000;
                        state <= 2'b00;
                    end else begin
                        z <= 1'b0;
                        state <= 2'b01;
                    end
                end
            endcase
        end
    end

endmodule
