module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack 
);

    reg [3:0] state;
    reg [3:0] next_state;
    reg [13:0] counter;
    reg [3:0] delay;
    reg [3:0] remaining_count;
    
    // State encoding
    localparam SEARCH      = 4'd0,
               SHIFT1      = 4'd1,
               SHIFT2      = 4'd2,
               SHIFT3      = 4'd3,
               SHIFT4      = 4'd4,
               COUNT       = 4'd5,
               WAIT_ACK    = 4'd6;
    
    // Clock edge triggered state transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
            counting <= 0;
            done <= 0;
            counter <= 0;
            delay <= 0;
            remaining_count <= 0;
        end else begin
            state <= next_state;
            if (state == COUNT)
                counter <= counter - 1;
        end
    end
    
    // Determine next state and state outputs
    always @(*) begin
        next_state = state;
        counting = 0;
        done = 0;
        case (state)
            SEARCH: begin
                if ({data, state[3:1]} == 4'b1101)
                    next_state = SHIFT1;
            end
            SHIFT1: next_state = SHIFT2;
            SHIFT2: next_state = SHIFT3;
            SHIFT3: next_state = SHIFT4;
            SHIFT4: begin
                next_state = COUNT;
                delay = {state[2:0], data}; // Store the delay value
                counter = ({state[2:0], data} + 1) * 1000;
                remaining_count = {state[2:0], data};
            end
            COUNT: begin
                counting = 1;
                if (counter == 0)
                    next_state = WAIT_ACK;
                else if ((counter % 1000) == 0)
                    remaining_count = remaining_count - 1;
            end
            WAIT_ACK: begin
                done = 1;
                counting = 0;
                if (ack)
                    next_state = SEARCH;
            end
        endcase
    end
    
    // Output current remaining time
    assign count = counting ? remaining_count : 4'bxxxx;

endmodule
