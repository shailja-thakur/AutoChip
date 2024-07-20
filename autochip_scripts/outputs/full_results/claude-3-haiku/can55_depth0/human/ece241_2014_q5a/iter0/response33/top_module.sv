module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [7:0] reg_input, reg_output;
reg input_valid;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        reg_input <= 0;
        reg_output <= 0;
        input_valid <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        if (state == CONVERT) begin
            reg_input <= {reg_input[6:0], x};
            input_valid <= 1;
        end
        else if (state == DONE) begin
            z <= reg_output[7];
        end
    end
end

always @* begin
    next_state = state;
    case (state)
        IDLE: begin
            if (~areset) next_state = CONVERT;
        end
        CONVERT: begin
            if (input_valid) next_state = DONE;
        end
        DONE: begin
            if (areset) next_state = IDLE;
        end
    endcase
end

always @* begin
    if (state == CONVERT) begin
        reg_output = ~reg_input + 1;
    end
    else begin
        reg_output = 0;
    end
end

endmodule
