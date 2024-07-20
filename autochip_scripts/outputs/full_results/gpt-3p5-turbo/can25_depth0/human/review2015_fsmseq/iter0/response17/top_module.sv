module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;
reg [1:0] input_history;

parameter IDLE = 2'b00;
parameter SEARCHING = 2'b01;
parameter FOUND = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (input_history == 4'b1101)
                    state <= FOUND;
                else
                    state <= SEARCHING;
            end
            SEARCHING: begin
                input_history <= {input_history[2:0], data};
                if (input_history == 4'b1101)
                    state <= FOUND;
            end
            FOUND: begin
                start_shifting <= 1;
                state <= IDLE;
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
