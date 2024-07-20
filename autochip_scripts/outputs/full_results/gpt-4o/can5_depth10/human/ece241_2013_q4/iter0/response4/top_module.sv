module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    // State Definitions
    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= LOW;
        else
            current_state <= next_state;
    end

    // Next State Logic and Output Logic
    always_comb begin
        case (current_state)
            LOW: begin
                if (s == 3'b000) begin
                    fr3 = 1; fr2 = 1; fr1 = 1; dfr = 1;
                    next_state = LOW;
                end 
                else if (s == 3'b001) begin
                    fr3 = 0; fr2 = 1; fr1 = 1; dfr = 1;
                    next_state = MID;
                end 
                else begin
                    fr3 = 0; fr2 = 0; fr1 = 0; dfr = 0;
                    next_state = HIGH;
                end
            end
            
            MID: begin
                if (s == 3'b001) begin
                    fr3 = 0; fr2 = 1; fr1 = 1; dfr = 1;
                    next_state = MID;
                end 
                else if (s == 3'b011) begin
                    fr3 = 0; fr2 = 0; fr1 = 1; dfr = 1;
                    next_state = HIGH;
                end 
                else begin
                    fr3 = 1; fr2 = 1; fr1 = 1; dfr = 1;
                    next_state = LOW;
                end
            end
            
            HIGH: begin
                if (s == 3'b111) begin
                    fr3 = 0; fr2 = 0; fr1 = 0; dfr = 0;
                    next_state = HIGH;
                end 
                else if (s == 3'b011) begin
                    fr3 = 0; fr2 = 0; fr1 = 1; dfr = 1;
                    next_state = MID;
                end 
                else begin
                    fr3 = 1; fr2 = 1; fr1 = 1; dfr = 1;
                    next_state = LOW;
                end
            end
        endcase
    end

endmodule
