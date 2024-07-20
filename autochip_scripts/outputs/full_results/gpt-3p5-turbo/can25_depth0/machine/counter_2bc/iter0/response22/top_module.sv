module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    localparam IDLE = 2'b00;
    localparam STATE1 = 2'b01;
    localparam STATE2 = 2'b10;
    localparam STATE3 = 2'b11;
    
    // Registers to hold the current state and next state
    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    // Synchronous reset
    always_ff @(posedge clk or negedge areset) begin
        if(!areset)
            curr_state <= STATE1;
        else
            curr_state <= next_state;
    end
    
    // Combinational logic to determine next state based on inputs
    always_comb begin
        next_state = curr_state;
        case(curr_state)
            IDLE: begin
                if(train_valid) begin
                    if(train_taken)
                        next_state = STATE1;
                    else
                        next_state = IDLE;
                end
            end
            STATE1: begin
                if(train_valid) begin
                    if(train_taken)
                        next_state = STATE2;
                    else
                        next_state = IDLE;
                end
                else
                    next_state = STATE1;
            end
            STATE2: begin
                if(train_valid) begin
                    if(train_taken)
                        next_state = STATE3;
                    else
                        next_state = STATE1;
                end
                else
                    next_state = STATE2;
            end
            STATE3: begin
                if(train_valid) begin
                    if(train_taken)
                        next_state = IDLE;
                    else
                        next_state = STATE2;
                end
                else
                    next_state = STATE3;
            end
        endcase
    end
    
    // Assign current state to output
    assign state = curr_state;

endmodule
