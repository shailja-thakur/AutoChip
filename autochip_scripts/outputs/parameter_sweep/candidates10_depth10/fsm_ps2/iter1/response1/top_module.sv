module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Registers for FSM state and current byte count
    reg [1:0] state;
    reg [2:0] count;
    
    // Constants for FSM states
    localparam IDLE = 2'b00;
    localparam SEARCH = 2'b01;
    localparam DONE = 2'b10;
    
    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            done <= 0; // Reset the 'done' signal
        end else begin
            case (state)
                IDLE: begin
                    state <= (in[3] == 1'b1) ? SEARCH : IDLE;
                    count <= 0;
                end
                SEARCH: begin
                    state <= (count == 2) ? DONE : SEARCH;
                    count <= (in[3] == 1'b1) ? 1 : 0;
                end
                DONE: begin
                    state <= IDLE;
                    count <= 0;
                    done <= 1; // Signal 'done' once all 3 bytes have been received
                end
            endcase
        end
    end
endmodule
