module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        count <= 3'b000;
        z <= 0;
    end else begin
        case(state)
            2'b00: begin
                if (s) begin
                    state <= 2'b01;
                    count <= 3'b000;
                end else begin
                    state <= 2'b00;
                    count <= 3'b000;
                end
            end
            2'b01: begin
                count <= count + 1;
                if (count >= 3) begin
                    if (count[1] + count[0] == 2) begin
                        state <= 2'b10;
                        count <= 3'b000;
                    end else begin
                        state <= 2'b00;
                        count <= 3'b000;
                    end
                end else begin
                    state <= 2'b01;
                    count <= count;
                end
            end
            2'b10: begin
                state <= 2'b00;
                count <= 3'b000;
                z <= 1;
            end
            default: begin
                state <= 2'b00;
                count <= 3'b000;
            end
        endcase
    end
end
endmodule
