module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
parameter IDLE = 2'b00, COMPUTE = 2'b01, OUTPUT = 2'b11;
reg [1:0] state, next_state;

// Internal registers
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
        state <= next_state;
        case (state)
            IDLE: begin
                input_num <= 8'b0;
                complement <= 8'b0;
                bit_count <= 4'b0;
                z <= 1'b0;
            end
            COMPUTE: begin
                input_num <= {input_num[6:0], x};
                complement <= {complement[6:0], ~x};
                bit_count <= bit_count + 1;
            end
            OUTPUT: begin
                z <= complement[bit_count];
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (areset == 1'b0) next_state = COMPUTE;
            else next_state = IDLE;
        end
        COMPUTE: begin
            if (bit_count == 4'd7) next_state = OUTPUT;
            else next_state = COMPUTE;
        end
        OUTPUT: begin
            if (bit_count == 4'd7) next_state = IDLE;
            else next_state = OUTPUT;
        end
        default: next_state = IDLE;
    endcase
end

endmodule
