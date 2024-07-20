module top_module(
    input clk,
    input rst,
    output reg out_valid,
    output reg [7:0] out_data
);

    // Internal signals
    reg [1:0] state;
    reg [7:0] counter;

    // FSM states
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    // Initializations
    initial begin
        state <= IDLE;
        counter <= 8'b0;
        out_data <= 8'b0;
        out_valid <= 1'b0;
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            counter <= 8'b0;
            out_data <= 8'b0;
            out_valid <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    out_data <= 8'b0;
                    if (rst) begin
                        state <= IDLE;
                    end else begin
                        state <= WAIT;
                    end
                end
                
                WAIT: begin
                    counter <= counter + 1;
                    out_data <= 8'b0;
                    if (counter == 8'hFF) begin
                        state <= PROCESS;
                    end
                end
                
                PROCESS: begin
                    out_data <= in;
                    state <= DONE;
                end
                
                DONE: begin
                    out_valid <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
