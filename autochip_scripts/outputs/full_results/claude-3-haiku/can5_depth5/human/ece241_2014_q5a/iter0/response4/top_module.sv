module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the state machine
localparam [1:0] 
    IDLE = 2'b00,
    COMPLEMENT = 2'b01,
    DONE = 2'b11;

reg [1:0] state, next_state;
reg [7:0] input_data, complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_data <= 8'b0;
        complement <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        input_data <= {input_data[6:0], x};
        complement <= complement - {7'b0, x};
        z <= (state == DONE) ? ~complement[7] : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (x == 1'b1) ? COMPLEMENT : IDLE;
        end
        COMPLEMENT: begin
            next_state = (complement[7] == 1'b1) ? DONE : COMPLEMENT;
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
