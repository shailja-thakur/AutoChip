module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_RESET = 2'b00;
localparam STATE_COMPUTE = 2'b01;
localparam STATE_DONE = 2'b10;

reg [1:0] state;
reg [7:0] input_num;
reg [7:0] complement;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        input_num <= 8'b0;
        complement <= 8'b0;
        bit_count <= 4'b0;
        z <= 1'b0;
    end else begin
        case (state)
            STATE_RESET: begin
                if (~areset) begin
                    state <= STATE_COMPUTE;
                end
            end
            STATE_COMPUTE: begin
                input_num[bit_count] <= x;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    complement <= ~input_num + 1;
                    state <= STATE_DONE;
                end
            end
            STATE_DONE: begin
                z <= complement[bit_count];
                if (bit_count == 4'd0) begin
                    state <= STATE_RESET;
                    bit_count <= 4'b0;
                end else begin
                    bit_count <= bit_count - 1;
                end
            end
        endcase
    end
end

endmodule
