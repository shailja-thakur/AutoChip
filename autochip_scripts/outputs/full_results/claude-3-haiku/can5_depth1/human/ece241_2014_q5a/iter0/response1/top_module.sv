module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the state parameters
parameter IDLE = 2'b00;
parameter COMPUTE = 2'b01;

// Internal signals
reg [1:0] state;
reg [7:0] input_num, complement;
reg [3:0] bit_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_num <= 8'b0;
        complement <= 8'b0;
        bit_count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= COMPUTE;
                    bit_count <= 4'b0;
                end
            end
            COMPUTE: begin
                if (bit_count < 8) begin
                    input_num <= {input_num[6:0], x};
                    bit_count <= bit_count + 1;
                end
                else begin
                    complement <= ~input_num + 1;
                    bit_count <= 4'b0;
                    state <= IDLE;
                    z <= complement[0];
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
