module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
localparam [1:0] 
    IDLE = 2'b00,
    COMPLEMENT = 2'b01,
    COMPLETE = 2'b10;

// Internal registers
reg [1:0] state;
reg [7:0] input_value;
reg [7:0] output_value;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_value <= 8'b0;
        output_value <= 8'b0;
        bit_count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (~x) begin
                    state <= COMPLEMENT;
                    input_value <= 8'b0;
                    bit_count <= 4'b0;
                end
            end
            COMPLEMENT: begin
                input_value <= {input_value[6:0], x};
                bit_count <= bit_count + 1;
                if (bit_count == 4'd7) begin
                    output_value <= ~input_value + 1;
                    state <= COMPLETE;
                end
            end
            COMPLETE: begin
                z <= output_value[bit_count];
                if (bit_count == 4'd0) begin
                    state <= IDLE;
                end
                else begin
                    bit_count <= bit_count - 1;
                end
            end
        endcase
    end
end

endmodule
