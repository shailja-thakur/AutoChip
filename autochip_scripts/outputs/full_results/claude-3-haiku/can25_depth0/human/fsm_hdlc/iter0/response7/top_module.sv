module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000,
                 DISC = 3'b001,
                 FLAG = 3'b010,
                 ERR  = 3'b011;

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
        count <= (next_state == state) ? count + 1 : 0;
        disc <= (next_state == DISC) ? 1 : 0;
        flag <= (next_state == FLAG) ? 1 : 0;
        err <= (next_state == ERR) ? 1 : 0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b1)
                next_state = DISC;
            else
                next_state = IDLE;
        end
        DISC: begin
            if (in == 1'b1)
                next_state = (count == 3'd4) ? FLAG : DISC;
            else
                next_state = IDLE;
        end
        FLAG: begin
            if (in == 1'b1)
                next_state = (count == 3'd6) ? IDLE : FLAG;
            else
                next_state = IDLE;
        end
        ERR: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
