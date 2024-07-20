module top_module(
    input wire clk,
    input wire rst,
    input wire in,
    output wire out);
    
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;
    
    // FSM states
    localparam IDLE = 2'b00;
    localparam WAIT = 2'b01;
    localparam PROCESS = 2'b10;
    localparam DONE = 2'b11;
    
    // Initial state and outputs
    assign out = (state == PROCESS) ? data : 8'b0;
    assign in = (state == DONE) ? 1'b1 : 1'b0;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 8'b0;
            data <= 8'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data <= 8'b0;
                    if (rst) state <= IDLE;
                    else state <= WAIT;
                end
                
                WAIT: begin
                    counter <= counter + 1;
                    data <= 8'b0;
                    if (counter == 8'd255) state <= PROCESS;
                    else state <= WAIT;
                end
                
                PROCESS: begin
                    data <= in;
                    state <= DONE;
                end
                
                DONE: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
