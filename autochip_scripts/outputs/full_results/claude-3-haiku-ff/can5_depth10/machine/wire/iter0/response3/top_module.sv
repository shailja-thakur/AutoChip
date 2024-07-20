module top_module(
    input clk,
    input reset,
    output data_out,
    output valid
);

reg state;
reg [7:0] counter;

parameter IDLE = 1'b0;
parameter WAIT = 1'b1;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 8'b0;
        data_out <= 1'b0;
        valid <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                counter <= 8'b0;
                data_out <= 1'b0;
                valid <= 1'b0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 1'b0;
                if (counter == 8'd100) begin
                    state <= PROCESS;
                end
                else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                data_out <= 1'b1; // Set the data output
                state <= DONE;
            end
            DONE: begin
                valid <= 1'b1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
