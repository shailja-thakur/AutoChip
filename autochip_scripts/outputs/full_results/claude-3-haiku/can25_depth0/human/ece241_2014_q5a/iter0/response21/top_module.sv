module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State definitions
parameter IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b11;

// Internal variables
reg [1:0] current_state, next_state;
reg [7:0] num_bits;
reg [7:0] complement;

// State transition logic
always @(*) begin
    case (current_state)
        IDLE: begin
            if (!areset)
                next_state = COMPUTE;
            else
                next_state = IDLE;
        end
        COMPUTE: begin
            if (num_bits == 8'd0)
                next_state = DONE;
            else
                next_state = COMPUTE;
        end
        DONE: begin
            if (areset)
                next_state = IDLE;
            else
                next_state = DONE;
        end
        default: next_state = IDLE;
    endcase
end

// State register
always @(posedge clk, posedge areset) begin
    if (areset)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

// Datapath logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        num_bits <= 8'd0;
        complement <= 8'd0;
        z <= 1'b0;
    end
    else begin
        case (current_state)
            IDLE: begin
                num_bits <= 8'd0;
                complement <= 8'd0;
                z <= 1'b0;
            end
            COMPUTE: begin
                num_bits <= num_bits + 8'd1;
                complement <= {complement[6:0], x};
                z <= complement[7];
            end
            DONE: begin
                z <= complement[7];
            end
            default: begin
                num_bits <= 8'd0;
                complement <= 8'd0;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
