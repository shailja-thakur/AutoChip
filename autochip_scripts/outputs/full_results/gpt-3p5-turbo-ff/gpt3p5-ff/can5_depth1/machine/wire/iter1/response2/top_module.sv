module top_module(
    input wire clock,
    input wire reset,
    input wire in,
    output wire out); 

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_output;
    reg valid_output;
    
    // FSM states
    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    always @(posedge clock or posedge reset) begin
        if (reset)
            state <= IDLE;
        else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data_output <= 8'b0;
                    valid_output <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_output <= 8'b0;
                    valid_output <= 1'b0;
                    if (counter >= 8'd10)
                        state <= PROCESS;
                end
                PROCESS: begin
                    data_output <= in;
                    valid_output <= 1'b0;
                    state <= DONE;
                end
                DONE: begin
                    valid_output <= 1'b1;
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end

    assign out = data_output;
endmodule
