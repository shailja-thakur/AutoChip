module top_module(
    input wire clk,
    input wire rst,
    input wire in,
    output reg out
);

reg [1:0] state;
reg [7:0] counter;
reg [7:0] data_output;
reg valid_output;

// FSM states
parameter IDLE = 2'b00;
parameter WAIT = 2'b01;
parameter PROCESS = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        counter <= 8'b0;
        data_output <= 8'b0;
        valid_output <= 0;
    end else begin
        case (state)
            IDLE: begin
                counter <= 8'b0;
                data_output <= 8'b0;
                valid_output <= 0;
                if (in) begin
                    state <= WAIT;
                end
            end
            
            WAIT: begin
                counter <= counter + 1;
                data_output <= 8'b0;
                valid_output <= 0;
                if (counter == 8'b11111111) begin
                    state <= PROCESS;
                end
            end
            
            PROCESS: begin
                data_output <= in;
                state <= DONE;
            end
            
            DONE: begin
                valid_output <= 1;
                state <= IDLE;
            end
            
            default: state <= IDLE;
        endcase
    end
end

assign out = valid_output ? data_output : 0;

endmodule
