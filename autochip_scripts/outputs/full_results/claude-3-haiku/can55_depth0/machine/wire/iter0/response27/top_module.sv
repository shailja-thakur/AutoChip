module top_module(
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid
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
        counter <= 8'b0;
        data_out <= 8'b0;
        valid <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 8'b0;
                if (counter == 8'd255) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                data_out <= stimulus_gen_module_output; // Assuming there is a module named stimulus_gen_module that generates the data
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
