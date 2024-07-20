module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] S_IDLE = 3'b000,
                 S_DISC = 3'b001,
                 S_FLAG = 3'b010,
                 S_ERR = 3'b011;

reg [2:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= S_IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        count <= in ? count + 1 : 0;
        disc <= (state == S_DISC);
        flag <= (state == S_FLAG);
        err <= (state == S_ERR);
    end
end

always @(*) begin
    next_state = state;
    case (state)
        S_IDLE: begin
            if (in) next_state = S_DISC;
        end
        S_DISC: begin
            if (in) begin
                if (count == 3'd5) next_state = S_FLAG;
                else next_state = S_DISC;
            end
            else next_state = S_IDLE;
        end
        S_FLAG: begin
            if (in) next_state = S_ERR;
            else next_state = S_IDLE;
        end
        S_ERR: begin
            if (in) next_state = S_ERR;
            else next_state = S_IDLE;
        end
        default: next_state = S_IDLE;
    endcase
end

endmodule
