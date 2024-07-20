module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] count;
wire start_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        count <= 2'b00;
        z <= 0;
    end else begin
        case (state)
            2'b00: begin
                if (s) begin
                    state <= 2'b01;
                end
            end
            2'b01: begin
                if (w) begin
                    count <= count + 2'b01;
                end
                state <= 2'b10;
            end
            2'b10: begin
                if (start_count) begin
                    count <= count + 2'b01;
                end
                state <= 2'b11;
            end
            2'b11: begin
                if (w) begin
                    count <= count + 2'b01;
                end
                if (count == 2'b10) begin
                    z <= 1;
                end else begin
                    z <= 0;
                end
                if (start_count) begin
                    state <= 2'b01;
                end else begin
                    state <= 2'b00;
                    count <= 2'b00;
                end
            end
        endcase
    end
end

assign start_count = (state == 2'b01) | (state == 2'b10);

endmodule
