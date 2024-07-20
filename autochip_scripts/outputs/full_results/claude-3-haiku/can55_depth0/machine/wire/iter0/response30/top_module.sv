module top_module(
    input clock,
    input reset,
    output reg [7:0] data_output,
    output reg valid_output
);

reg [1:0] state;
reg [7:0] counter;

parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        data_output <= 0;
        valid_output <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                counter <= 0;
                data_output <= 0;
                valid_output <= 0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_output <= 0;
                if (counter == 8'd100) begin
                    state <= PROCESS;
                end
                else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                data_output <= 8'hAB; // Replace with your processing logic
                state <= DONE;
            end
            DONE: begin
                valid_output <= 1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
