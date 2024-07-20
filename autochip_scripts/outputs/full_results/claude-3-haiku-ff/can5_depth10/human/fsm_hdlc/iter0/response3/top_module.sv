module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000;
localparam [2:0] ONE_SEEN = 3'b001;
localparam [2:0] TWO_SEEN = 3'b010;
localparam [2:0] THREE_SEEN = 3'b011;
localparam [2:0] FOUR_SEEN = 3'b100;
localparam [2:0] FIVE_SEEN = 3'b101;
localparam [2:0] SIX_SEEN = 3'b110;
localparam [2:0] SEVEN_SEEN = 3'b111;

reg [2:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = ONE_SEEN;
            end else begin
                next_state = IDLE;
            end
        end
        ONE_SEEN: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = TWO_SEEN;
            end else begin
                next_state = IDLE;
            end
        end
        TWO_SEEN: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = THREE_SEEN;
            end else begin
                next_state = IDLE;
            end
        end
        THREE_SEEN: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = FOUR_SEEN;
            end else begin
                next_state = IDLE;
            end
        end
        FOUR_SEEN: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = FIVE_SEEN;
            end else begin
                next_state = IDLE;
            end
        end
        FIVE_SEEN: begin
            disc = 1'b1;
            flag = 1'b0;
            err = 1'b0;
            if (in == 1'b0) begin
                next_state = IDLE;
            end else begin
                next_state = SIX_SEEN;
            end
        end
        SIX_SEEN: begin
            disc = 1'b0;
            flag = 1'b1;
            err = 1'b0;
            if (in == 1'b1) begin
                next_state = SEVEN_SEEN;
            end else begin
                next_state = IDLE;
            end
        end
        SEVEN_SEEN: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b1;
            if (in == 1'b1) begin
                next_state = SEVEN_SEEN;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            disc = 1'b0;
            flag = 1'b0;
            err = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
