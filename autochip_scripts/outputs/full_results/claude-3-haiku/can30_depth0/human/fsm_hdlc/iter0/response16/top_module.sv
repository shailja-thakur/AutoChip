module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

`define IDLE 3'b000
`define DISC 3'b001
`define FLAG 3'b010
`define ERR  3'b011

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= `IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        `IDLE: begin
            disc = 0;
            flag = 0;
            err = 0;
            if (in == 1'b1) begin
                next_state = `DISC;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `DISC: begin
            disc = 1;
            flag = 0;
            err = 0;
            if (in == 1'b1) begin
                next_state = `FLAG;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `FLAG: begin
            disc = 0;
            flag = 1;
            err = 0;
            if (in == 1'b1) begin
                next_state = `ERR;
            end
            else begin
                next_state = `IDLE;
            end
        end
        `ERR: begin
            disc = 0;
            flag = 0;
            err = 1;
            next_state = `IDLE;
        end
        default: begin
            disc = 0;
            flag = 0;
            err = 0;
            next_state = `IDLE;
        end
    endcase
end

endmodule
