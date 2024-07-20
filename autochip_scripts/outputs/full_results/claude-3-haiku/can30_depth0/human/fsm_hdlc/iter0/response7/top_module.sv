module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 DISCARD = 3'b001,
                 FLAG = 3'b010,
                 ERROR = 3'b011;

reg [2:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        count <= in ? (count + 1) : 0;
        disc <= (state == DISCARD);
        flag <= (state == FLAG);
        err <= (state == ERROR);
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (in) ? DISCARD : IDLE;
        end
        DISCARD: begin
            next_state = (count == 3'b101) ? FLAG : DISCARD;
        end
        FLAG: begin
            next_state = (in) ? ERROR : IDLE;
        end
        ERROR: begin
            next_state = (in) ? ERROR : IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
