module top_module(
    input wire clk,
    input wire reset,
    output reg out,
    output reg valid);
    
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_output;
    
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else case (state)
            IDLE: begin
                counter <= 8'h00;
                data_output <= 8'h00;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_output <= 8'h00;
                if (counter == 8'hFF)
                    state <= PROCESS;
            end
            PROCESS: begin
                data_output <= input;
                state <= DONE;
            end
            DONE: state <= IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (state == DONE)
            valid <= 1'b1;
        else
            valid <= 1'b0;
    end
    
    assign out = data_output;
endmodule
