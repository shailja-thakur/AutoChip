module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] count;

parameter A = 2'b00, B = 2'b01, C = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                    count <= 0;
                end
                else begin
                    state <= A;
                    count <= 0;
                end
            end
            B: begin
                if (count < 2) begin
                    if (w) begin
                        count <= count + 1;
                    end
                    else begin
                        count <= count;
                    end
                    state <= B;
                end
                else begin
                    if (count == 2) begin
                        z <= 1;
                    end
                    else begin
                        z <= 0;
                    end
                    state <= C;
                    count <= 0;
                end
            end
            C: begin
                if (count < 2) begin
                    if (w) begin
                        count <= count + 1;
                    end
                    else begin
                        count <= count;
                    end
                    state <= C;
                end
                else begin
                    if (count == 2) begin
                        z <= 1;
                    end
                    else begin
                        z <= 0;
                    end
                    state <= B;
                    count <= 0;
                end
            end
        endcase
    end
end

endmodule
