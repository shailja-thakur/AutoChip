module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Registers for FSM state and current byte count
    reg [1:0] state_reg;
    reg [2:0] count_reg;
    
    // Constants for FSM states
    localparam IDLE = 2'b00;
    localparam SEARCH = 2'b01;
    localparam DONE = 2'b10;
    
    // Next state and next count
    reg [1:0] state_next;
    reg [2:0] count_next;
    
    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state_reg <= IDLE;
            count_reg <= 0;
        end else begin
            state_reg <= state_next;
            count_reg <= count_next;
        end
    end

    always @(*) begin
        state_next = state_reg;
        count_next = count_reg;
        case (state_reg)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    state_next = SEARCH;
                    count_next = 0;
                end
            end
            SEARCH: begin
                if (count_reg == 2) begin
                    state_next = DONE;
                    count_next = 0;
                end else begin
                    if (in[3] == 1'b1) begin
                        count_next = count_reg + 1;
                    end
                end
            end
            DONE: begin
                state_next = IDLE;
                count_next = 0;
            end
        endcase
    end

    // Output assignment
    assign done = (state_reg == DONE);
    
endmodule
