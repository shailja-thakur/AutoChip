module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
localparam [1:0] 
    S_INIT = 2'b00,
    S_ONES = 2'b01,
    S_FLAG = 2'b10,
    S_ERR  = 2'b11;

// State register
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        S_INIT: begin
            if (in == 1'b1) begin
                next_state = S_ONES;
            end else begin
                next_state = S_INIT;
            end
        end
        S_ONES: begin
            if (in == 1'b1) begin
                next_state = S_ONES;
            end else begin
                next_state = S_INIT;
            end
        end
        S_FLAG: begin
            if (in == 1'b1) begin
                next_state = S_ERR;
            end else begin
                next_state = S_INIT;
            end
        end
        S_ERR: begin
            if (in == 1'b1) begin
                next_state = S_ERR;
            end else begin
                next_state = S_INIT;
            end
        end
        default: begin
            next_state = S_INIT;
        end
    endcase
end

// Output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        S_INIT: begin
            // Do nothing
        end
        S_ONES: begin
            if (in == 1'b0) begin
                disc = 1'b1;
            end
        end
        S_FLAG: begin
            flag = 1'b1;
        end
        S_ERR: begin
            err = 1'b1;
        end
        default: begin
            // Do nothing
        end
    endcase
end

// State update logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_INIT;
    end else begin
        state <= next_state;
    end
end

endmodule
