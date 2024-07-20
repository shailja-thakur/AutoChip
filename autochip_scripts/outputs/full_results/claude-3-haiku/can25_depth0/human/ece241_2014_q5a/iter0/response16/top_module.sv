module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
localparam STATE_IDLE = 2'b00;
localparam STATE_CONVERT = 2'b01;
localparam STATE_DONE = 2'b11;

// Internal registers
reg [1:0] state;
reg [7:0] input_num;
reg [7:0] complement;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_IDLE;
        bit_count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (!areset) begin
                    state <= STATE_CONVERT;
                    input_num <= 0;
                    complement <= 0;
                    bit_count <= 0;
                end
            end
            STATE_CONVERT: begin
                input_num <= {input_num[6:0], x};
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin
                    complement <= ~input_num + 1;
                    state <= STATE_DONE;
                end
            end
            STATE_DONE: begin
                z <= complement[0];
                complement <= {1'b0, complement[7:1]};
                if (bit_count == 0) begin
                    state <= STATE_IDLE;
                end
                else begin
                    bit_count <= bit_count - 1;
                end
            end
        endcase
    end
end

endmodule
