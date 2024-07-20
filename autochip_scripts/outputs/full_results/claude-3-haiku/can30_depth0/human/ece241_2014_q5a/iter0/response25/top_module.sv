module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State definitions
localparam [1:0] IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;

// Internal registers
reg [7:0] num, neg_num;
reg [3:0] count;

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (!areset)
                next_state = CONVERT;
            else
                next_state = IDLE;
        end
        CONVERT: begin
            if (count == 8)
                next_state = DONE;
            else
                next_state = CONVERT;
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

// State transition
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= IDLE;
    else
        state <= next_state;
end

// Data path logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        num <= 8'b0;
        neg_num <= 8'b0;
        count <= 4'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                num <= 8'b0;
                neg_num <= 8'b0;
                count <= 4'b0;
                z <= 1'b0;
            end
            CONVERT: begin
                num <= {num[6:0], x};
                neg_num <= ~num + 1'b1;
                count <= count + 1'b1;
                z <= neg_num[count];
            end
            DONE: begin
                z <= 1'b0;
            end
            default: begin
                num <= 8'b0;
                neg_num <= 8'b0;
                count <= 4'b0;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
