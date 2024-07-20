module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter IDLE = 3'b000, DIS = 3'b001, FLAG = 3'b010, ERR = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end else begin
        case (state)
            IDLE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    state <= DIS;
                end else begin
                    state <= IDLE;
                end
            end
            DIS: begin
                disc <= 1;
                flag <= 0;
                err <= 0;
                if (in) begin
                    state <= FLAG;
                end else begin
                    state <= IDLE;
                end
            end
            FLAG: begin
                disc <= 0;
                flag <= 1;
                err <= 0;
                if (in) begin
                    state <= ERR;
                end else begin
                    state <= IDLE;
                end
            end
            ERR: begin
                disc <= 0;
                flag <= 0;
                err <= 1;
                if (in) begin
                    state <= ERR;
                end else begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
